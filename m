Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWJ2LT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWJ2LT4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 06:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWJ2LTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 06:19:55 -0500
Received: from web27408.mail.ukl.yahoo.com ([217.146.177.184]:61877 "HELO
	web27408.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932213AbWJ2LTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 06:19:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=jx7dhoBmuv1eNmkbXscIlnjTtyWjSwktTbj0c6Nk5+IsirmUEnBadb+Dn9vUxZqQ5pMIJt5FXdwxJJcL4f0I50DGzvHtlCj81/mWcYItogQEBupgk/UlnSHdeHZ/isalegbGlc3CBZ6XrXwQZz56CQWvaFmQznfETEGhqV210l4=  ;
Message-ID: <20061029111953.51907.qmail@web27408.mail.ukl.yahoo.com>
Date: Sun, 29 Oct 2006 11:19:53 +0000 (GMT)
From: ranjith kumar <ranjit_kumar_b4u@yahoo.co.uk>
Subject: Re: How to run an a.out file in a kernel module
To: linux-kernel@vger.kernel.org
In-Reply-To: <20061027110636.GA2837@harddisk-recovery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    1) What is the synatx of call_usermodehelper()
function?
        I found out that it takes 4 arguments. But
what values  we have to pass as argumets.
I did searched in internet. But could not find out.
Sorry to post this question.

2) How to print something  using C code such that it
will be displayed when corresponding a.out file is
called in a kernel module using call_usermodehelper()
function.

Thanks in advance.

--- Erik Mouw <erik@harddisk-recovery.com> wrote:

> On Fri, Oct 27, 2006 at 11:16:11AM +0100, ranjith
> kumar wrote:
> >           How to run an a.out file in a kernel
> module
> >              I tried to include
> >                                    
> system("./a.out");
> >      in the C file. But I got compilation errors.
> 
> Simple: you don't. There are a bunch of problems
> over here:
> 
> 1) The system() call is a userland libc call and
> doesn't exist in the
>    kernel
> 2) You can't be sure you're in user context
> 3) You don't know in what filesytem namespace you
> are
> 
> You could use call_usermodehelper() if you really
> need to call a
> usermode helper, but usually it's a sign of bad
> design if you need to.
> 
> 
> Erik
> 
> -- 
> +-- Erik Mouw -- www.harddisk-recovery.com -- +31 70
> 370 12 90 --
> | Lab address: Delftechpark 26, 2628 XH, Delft, The
> Netherlands
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



		
___________________________________________________________ 
All New Yahoo! Mail – Tired of Vi@gr@! come-ons? Let our SpamGuard protect you. http://uk.docs.yahoo.com/nowyoucan.html
