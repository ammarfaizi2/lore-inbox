Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbVL0BrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbVL0BrM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 20:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVL0BrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 20:47:12 -0500
Received: from web53708.mail.yahoo.com ([206.190.37.29]:26007 "HELO
	web53708.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932189AbVL0BrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 20:47:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=E9OgRdTm51T3jEKrwh/x7J0q6u12EM40z3XSFi7eAOTtNZA2wjNwrlRVNpM/xICofHJtEXX2uLViiQE/RZUjAsRM1HDtJINDkG3O8OwHaA0cjx+FgRwmYOv+rEuBBTuns9eZCUa39DX+joyq2ta2Y+Okn14w9aAFXqB0166w1wQ=  ;
Message-ID: <20051227014710.43609.qmail@web53708.mail.yahoo.com>
Date: Mon, 26 Dec 2005 17:47:10 -0800 (PST)
From: Mikado <mikado4vn@yahoo.com>
Subject: Re: How to obtain process ID that created a packet
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, linux-c-programming@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0512262334210.12671@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Hi,
> >
> >Is there any way to catch REAL pid that generated a packet from 'struct sk_buff', 'struct
sock', 'struct socket', 'struct file' or etc... ? direct/indirect ways are accepted.
> 
> The question is: when do you test for the PID? You would have to do it 
> within send(), because anywhere else, you do not know. A socket may be 
> shared among multiple processes (most simple way: fork()).

I'm hooking in NF_IP_LOCAL_OUT of netfilter code using nf_register_hook() function.

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
