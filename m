Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263468AbTJBS4f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 14:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263470AbTJBS4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 14:56:35 -0400
Received: from chaos.analogic.com ([204.178.40.224]:31874 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263468AbTJBS4d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 14:56:33 -0400
Date: Thu, 2 Oct 2003 14:59:28 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Hans-Georg Thien <1682-600@onlinehome.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: getting timestamp of last interrupt?
In-Reply-To: <3F7C6319.4010407@onlinehome.de>
Message-ID: <Pine.LNX.4.53.0310021454370.9782@chaos>
References: <3EB19625.6040904@onlinehome.de> <3EBAAC12.F4EA298D@hp.com>
 <3ED3CECA.9020706@onlinehome.de> <20030527231026.6deff7ed.subscript@free.fr>
 <3F7C6319.4010407@onlinehome.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Oct 2003, Hans-Georg Thien wrote:

> I am looking for a possibility to read out the last timestamp when an
> interrupt has occured.
>
> e.g.: the user presses a key on the keyboard. Where can I read out the
> timestamp of this event?

You can get A SIGIO signal for every keyboard, (or other input) event.
What you do with it is entirely up to you. Linux/Unix doesn't have
"callbacks", instead it has signals. It also has select() and poll(),
all useful for handling such events. If you want a time-stamp, you
call gettimeofday() in your signal handler.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


