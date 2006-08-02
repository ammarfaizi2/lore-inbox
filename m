Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWHBDz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWHBDz7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 23:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWHBDz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 23:55:59 -0400
Received: from smtp103.rog.mail.re2.yahoo.com ([206.190.36.81]:39098 "HELO
	smtp103.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751123AbWHBDz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 23:55:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:From:Organization:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=N3oQOMUim361lLnGkWunxMBvdqgsQC9ixeIXExAzgb2FGLuuAow1a0eMk/bUJopuLKWOUh/43K9B3xNnF+bidgGYKvh34MLLSFlW49utzhMA4jUKmcxysezOM+d0iVWVUeAmYah5wIzkyNIvoJ4zTXvRabhiEthxYEy4TomvX3E=  ;
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: Auke Kok <auke-jan.h.kok@intel.com>
Subject: Re: [2.6.18-rc2][e1000][swsusp] - Regression - Suspend to disk and resume breaks e1000 - RESOLVED Bug #6867
Date: Tue, 1 Aug 2006 23:55:28 -0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, NetDev <netdev@vger.kernel.org>
References: <200607160509.52930.shawn.starr@rogers.com> <44BA6A4A.5090007@intel.com>
In-Reply-To: <44BA6A4A.5090007@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608012355.28504.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 July 2006 12:33 pm, Auke Kok wrote:
> [adding netdev to the cc]
>
> unfortunately I didn't.
>
> e1000 has a special e1000_pci_save_state/e1000_pci_restore_state set of
> routines that save and restore the configuration space. the fact that it
> works for suspend to memory to me suggests that there is nothing wrong with
> that.
>
> I'm surprised that the t42 comes with a PCI/PCI-X e1000, which changes the
> need for this special routine, and the routine does the exact same thing as
> pci_save_state in your case. These special routines are made to handle
> PCI-E cards properly.
>
> Also there are no config_pm changes related to this in 2.6.18-rc2. Most of
> this code has been in the kernel for a few major releases afaik. This code
> worked fine before, so I don't rule out any suspend-related issues. You
> should certainly compare with 2.6.18-rc1 and make sure it was a regression,
> perhaps even bisect the e1000-related changes if you have the time, which
> is about 22 patches or so.
>
> I'll see if I can find out some more once I get back to work.
>
> Auke

Hi Auke,

It appears 2.6.18-rc3 this does not occur anymore. I suspended to disk/ram and 
the interface pci registers were restored. Bugzilla #6867

Thanks, 

Shawn.



