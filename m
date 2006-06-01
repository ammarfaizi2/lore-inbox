Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbWFAThU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWFAThU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 15:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965290AbWFAThU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 15:37:20 -0400
Received: from wx-out-0102.google.com ([66.249.82.203]:1876 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965280AbWFAThS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 15:37:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A4VUhR7zw5L5WF/O3/wT1VRZ53TNF9cefuiMeei77gy8jpofsxVE1DdRCpY8srjiYWW+A3cR1Inl+CixHFCynVrGUovw7DjaIqHQfiPn0DJNdLH7YnVI5RxcZpqp67jiHPRco6uyLNNkfwR0ZCvtaSz8p5De1AIEFUKFrLBQbRA=
Message-ID: <d120d5000606011237x33b347a3h88847a4d7e2fc10f@mail.gmail.com>
Date: Thu, 1 Jun 2006 15:37:18 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Gerhard Mack" <gmack@innerfire.net>
Subject: Re: linux 2.6.16.16 breaks touchscreens
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605190932470.16521@mtl.rackplans.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0605190932470.16521@mtl.rackplans.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/06, Gerhard Mack <gmack@innerfire.net> wrote:
> hello,
>
> I have a touchscreen device that works on 2.6.14 but breaks on 2.6.16.
>
> The kernel is detecting the device and it is registering in
> /proc/bus/input/devices but not showing up in /dev/input
>
> dmesg:
>
> input: eGalax Inc. USB TouchController as /class/input/input0
> usbcore: registered new driver touchkitusb
> mice: PS/2 mouse device common for all mice
> ts: Compaq touchscreen protocol output
>
> /proc/bus/usb/devices:
> I: Bus=0003 Vendor=0eef Product=0001 Version=0100
> N: Name="eGalax Inc. USB TouchController"
> P: Phys=/input0
> S: Sysfs=/class/input/input0
> H: Handlers=mouse0 event0 ts0
> B: EV=b
> B: KEY=400 0 0 0 0 0 0 0 0 0 0
> B: ABS=3
>
> kiosk10:/dev/input# ls -l
> total 0
> crw-rw----  1 root root 13,  63 2006-05-19 09:06 mice
> crw-rw----  1 root root 10, 223 2006-05-19 09:06 uinput
>

Gerhard,

Were you able to resolve this issue? It looks like your device is
properly recognized by the kernel and I see that "ts" handler was
bound to it so the only thing missingis the device node. I am pretty
sure it is udev issue.

-- 
Dmitry
