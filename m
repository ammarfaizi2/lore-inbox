Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131414AbRBWLzP>; Fri, 23 Feb 2001 06:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131537AbRBWLzF>; Fri, 23 Feb 2001 06:55:05 -0500
Received: from hal.famaf.unc.edu.ar ([200.16.17.122]:41732 "EHLO
	hal.famaf.unc.edu.ar") by vger.kernel.org with ESMTP
	id <S131414AbRBWLyx>; Fri, 23 Feb 2001 06:54:53 -0500
Date: Fri, 23 Feb 2001 08:51:55 -0300 (ART)
From: Edgardo Hames - 98130730 <ehames@hal.famaf.unc.edu.ar>
To: <linux-kernel@vger.kernel.org>
Subject: Select call for a device driver problem
Message-ID: <Pine.LNX.4.30.0102230848500.6348-100000@multivac.famaf.unc.edu.ar>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello people out there,
We are writing a driver for a device which can be read and written. When a
process tries to read from it and there is nothing in its buffer, we tell
it
to sleep until another process writes to the device. When writing, if the
buffer is full, we tell it to sleep until something is read from the
device.
This is done in the read and write operations for the device, and they
work
well. However, when we do a select on a file descriptor of the device, we
go
right through it and the process is never blocked. What am I doing wrong?
Am
I supposed to check whether the device is opened O_RDONLY, O_WRONLY,
O_RDWR?
If so, where do I do that?
Please include this address in any answer since I'm not
subscribed to the list.
Edgardo Hames
ehames@hal.famaf.unc.edu.ar
Julio Bianco
jbianco@hal.famaf.unc.edu.ar

-- 
Edgardo Hames

