Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932898AbWKLNrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932898AbWKLNrr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 08:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932889AbWKLNrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 08:47:47 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40424 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932898AbWKLNrq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 08:47:46 -0500
Message-Id: <1163339265.29537.275608001@webmail.messagingengine.com>
X-Sasl-Enc: seTO0waaf0g6CmwaS49OS8Ogu/BcoE2NvD/RsdKAgsl6 1163339265
From: "Alexander van Heukelum" <heukelum@fastmail.fm>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Vivek Goyal" <vgoyal@in.ibm.com>
Cc: "Alexander van Heukelum" <heukelum@mailshack.com>,
       "Steven Rostedt" <rostedt@goodmis.org>, "Andi Kleen" <ak@suse.de>,
       "LKML" <linux-kernel@vger.kernel.org>, sct@redhat.com,
       herbert@gondor.apana.org.au, xen-devel@lists.xensource.com
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface
References: <Pine.LNX.4.58.0611082144410.17812@gandalf.stny.rr.com>
   <200611091433.09232.ak@suse.de>
   <20061109183111.GA32438@mailshack.com>
   <200611101501.40007.ak@suse.de> <20061110154600.GA826@mailshack.com>
Subject: Re: [PATCH] shorten the x86_64 boot setup GDT to what the comment says
In-Reply-To: <20061110154600.GA826@mailshack.com>
Date: Sun, 12 Nov 2006 14:47:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Nov 2006 16:46:00 +0100, "Alexander van Heukelum"
<heukelum@mailshack.com> said:
> On Fri, Nov 10, 2006 at 03:01:39PM +0100, Andi Kleen wrote:
> > > Hi Andi,
> > > 
> > > (Assuming you mean: "The gdt table already is 16-byte aligned.")
> > > 
> > > Hmm. Not in the most recent version of Linus' tree, not even by
> > > concidence, and none of the patches in your quilt-current/patches touch
> > > x86_64's version of setup.S. Am I missing something?
> > 
> > The main GDT is. The boot GDT isn't, but it doesn't matter because
> > it is only used for a very short time.
> 
> Aha, thanks for clearing that up. I agree it is not important to have
> the boot GDT aligned, but I think it is preferable to make parts of the
> two versions of setup.S equal if possible.
> 
> Let's see what Steven Rostedt comes up with.
> 
> I find the relocatable image patches interesting. I wonder if one can
> get such a kernel 'running' using bochs, freedos, and loadlin ;).

Was it clear that I was sceptical about this still working? Oh well,
I tried it, and it did not break. Freedos' versions of himem and emm386 
loaded, DOS=HIGH,UMB.

Alexander
-- 
  Alexander van Heukelum
  heukelum@fastmail.fm

-- 
http://www.fastmail.fm - Same, same, but different…

