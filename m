Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261545AbSLCP1z>; Tue, 3 Dec 2002 10:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261573AbSLCP1z>; Tue, 3 Dec 2002 10:27:55 -0500
Received: from dux1.tcd.ie ([134.226.1.23]:44551 "HELO dux1.tcd.ie")
	by vger.kernel.org with SMTP id <S261545AbSLCP1y> convert rfc822-to-8bit;
	Tue, 3 Dec 2002 10:27:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Salman <assembly@gofree.indigo.ie>
To: linux-kernel@vger.kernel.org
Subject: device driver modules
Date: Tue, 3 Dec 2002 15:34:02 +0000
User-Agent: KMail/1.4.3
References: <3DECBCA7.2010502@earthlink.net> <3DECC289.2050500@vgertech.com>
In-Reply-To: <3DECC289.2050500@vgertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212031534.02102.assembly@gofree.indigo.ie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I'm working with a device driver which comes in 2 modules.

One directly talking to the hardware and kernel, and the other sitting on top 
of it, in user mode providing a nice interface for user applications and etc.

Basically the top layer should directly communicate with bottom layer for any 
action.
I'm going through code of top layer, and it never calls the lower layer 
functions ! a sample code traverses as follows (i used source navigator to go 
through code)

ConnectRemoteSegment -> kcConnectR -> SISCI_IOCTL -> unixIoctl -> ioctl

all above fucntions are within the top layer code.
none are even listed in /proc/ksyms
and the ioctl function simply doesn't exist, not even in kernel source code.

I know i'm missing a major concept here, can someone guide me how to 
understand what's going on.

Thanks,

Salman
