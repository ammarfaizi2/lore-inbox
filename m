Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318708AbSH1EZE>; Wed, 28 Aug 2002 00:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318709AbSH1EZE>; Wed, 28 Aug 2002 00:25:04 -0400
Received: from adsl-67-117-146-62.dsl.snfc21.pacbell.net ([67.117.146.62]:42503
	"EHLO localhost") by vger.kernel.org with ESMTP id <S318708AbSH1EZD>;
	Wed, 28 Aug 2002 00:25:03 -0400
From: "Stephen Biggs" <s.biggs@softier.com>
To: "David S. Miller" <davem@redhat.com>
Date: Tue, 27 Aug 2002 21:29:06 -0700
MIME-Version: 1.0
Subject: Re: Bug in kernel code?
CC: linux-kernel@vger.kernel.org
Message-ID: <3D6BEF22.21951.10E69E8@localhost>
In-reply-to: <20020827.203946.102043898.davem@redhat.com>
References: <3D6BD62C.581.ACEBAD@localhost>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Aug 2002 at 20:39, David S. Miller wrote:

>    How about (unsigned long)(~0)?
>    
> Realistically possible with any known configuration?
> 

You tell me.  You're saying a billion pages (((unsigned long)(~0)) >> 2) also crashes) is never 
going to be realistically possible?  Sounds like Bill Gates when he said (and I don't know the word-
for-word quote) "Who's ever going to need more than 640K??"  What if we get into 64 bit addressing? 
What if there is some sort of bug that passes all 1s on the stack for just this one instance?  
Never could "realistically" happen? Yeah, right; I've seen weirder things than that.

It's a question of mandatory paranoid sanity checking in an OS wherever possible.  Linux is trying 
to be known as robust.  Are you saying that a supposedly robust kernel should have a chance to 
crash in an infinite loop during initialization because there isn't code doing input validation 
when there isn't an optimization or speed issue?

