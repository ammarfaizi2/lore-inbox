Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261925AbSITJjB>; Fri, 20 Sep 2002 05:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261964AbSITJjB>; Fri, 20 Sep 2002 05:39:01 -0400
Received: from pc-80-195-34-180-ed.blueyonder.co.uk ([80.195.34.180]:31872
	"EHLO sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S261925AbSITJjA>; Fri, 20 Sep 2002 05:39:00 -0400
Date: Fri, 20 Sep 2002 10:44:00 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Seaman Hu <seaman_hu@yahoo.com>,
       ext3-users@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: What will happen when disk(ext3) is full while i continue to operate files ?
Message-ID: <20020920104400.F2585@redhat.com>
References: <20020920073927.71003.qmail@web40504.mail.yahoo.com> <20020920091114.46162.qmail@web40502.mail.yahoo.com> <20020920102052.B2585@redhat.com> <200209201127.28482.duncan.sands@math.u-psud.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209201127.28482.duncan.sands@math.u-psud.fr>; from duncan.sands@math.u-psud.fr on Fri, Sep 20, 2002 at 11:27:28AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 20, 2002 at 11:27:28AM +0200, Duncan Sands wrote:
> > Ah, that's a known problem when you run out of inodes.  Ext3
> > incorrectly treated it as a full fs error.  That's been fixed in -ac,
> > ext3 CVS and the Red Hat kernels for a while, and it's in Marcelo's
> > post-2.4.19 tree.
> 
> Do you know a good way to recover from this when it happens?
> The problem being that when you reboot it immediately happens
> again...  I managed to recover from this but it required some time
> and tricks (see other email to list) - perhaps you know an easy way?

Mounting with "errors=continue" will make the kernel ignore the error
when it occurs.

Cheers,
 Stephen
