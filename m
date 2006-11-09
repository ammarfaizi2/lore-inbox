Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161828AbWKIULy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161828AbWKIULy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 15:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161825AbWKIULy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 15:11:54 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:50148 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161828AbWKIULx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 15:11:53 -0500
Date: Thu, 9 Nov 2006 15:11:18 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Jay Lan <jlan@sgi.com>
Cc: Don Zickus <dzickus@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       "Lu, Yinghai" <yinghai.lu@amd.com>
Subject: Re: [Fastboot] Kexec with latest kernel fail
Message-ID: <20061109201118.GB23081@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <5986589C150B2F49A46483AC44C7BCA49071BF@ssvlexmb2.amd.com> <20061109163922.GE5622@redhat.com> <45538A4E.6040404@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45538A4E.6040404@sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2006 at 12:06:38PM -0800, Jay Lan wrote:
> Don Zickus wrote:
> > On Wed, Nov 08, 2006 at 08:07:22PM -0800, Lu, Yinghai wrote:
> >> Eric,
> >>
> >> I got "Invalid memory segment 0x100000 - ..."
> >> using kexec latest kernel...
> > 
> > I usually see this when people forget to add the "crashkernel=X@Y" into
> > their /etc/grub.conf kernel command line.  Where X and Y are arch
> > specific.
> 
> I have had "Invalid memory segment 0x4000000 - 0x4997fff" problem with
> '-l' option _always_. Since my priority was on '-p' i did not spent time
> on debugging this problem yet...
> 
> Maybe this "crashkerenl=X@Y" was the cause of my problem? Some platform
> can not specify a location to load so that it is legal to only specify
> "crashkernel=X" now. Is it possible '-l' code path still expect to
> see Y?
> 

kexec -l patch does not worry about crashkernel=. Only kexec -p path
does. So this is something else.

Thanks
Vivek
