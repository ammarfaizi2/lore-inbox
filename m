Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314047AbSEFBdh>; Sun, 5 May 2002 21:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314051AbSEFBdg>; Sun, 5 May 2002 21:33:36 -0400
Received: from oak.sktc.net ([208.46.69.4]:33040 "EHLO oak.sktc.net")
	by vger.kernel.org with ESMTP id <S314047AbSEFBdg>;
	Sun, 5 May 2002 21:33:36 -0400
Message-ID: <3CD5DD6D.60800@sktc.net>
Date: Sun, 05 May 2002 20:33:33 -0500
From: "David D. Hagood" <wowbagger@sktc.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020413
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Justin Piszcz <war@starband.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux & X11 & IRQ Interrupts
In-Reply-To: <3CD5D57D.DED89DFC@starband.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:

> With the console speaker attached, it can be clearly heard, as well as
> performing fast packet movements (nmap (with insane option)) or such you
> can literally hear the packets.


What you are hearing is the noise in the computer's power supply. As the 
load on the power supply changes, the voltage changes by a few tens of 
millivolts, and that is the noise you are hearing.

This primary reason you don't hear this under Windows and you hear it 
under Linux is that Linux will shut the processor off when there is 
nothing to do, greatly reducing the load on the power supply. When 
something happens, like a mouse interrupt or a network interrupt, the 
CPU springs back to life, drawing a burst of power from the power supply 
and momentarily bringing the voltage down a bit. This cycling of the CPU 
happens in microseconds.

Windows, especially older versions of Windows, doesn't do this - when 
there is no work for the CPU, it spins in a busy loop looking for work. 
As a result, the load on the power supply never changes. Of course, your 
system will also run hotter and burn more power.

If this bothers you, you could try getting another power supply (one 
that is "stiffer" and less prone to voltage sag) or you could run a 
program like Seti@home or Distributed.Net and keep your CPU busy all the 
time.



