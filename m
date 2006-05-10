Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbWEJJY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWEJJY4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 05:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWEJJY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 05:24:56 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:29421 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750955AbWEJJYz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 05:24:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jDYlvxmMd4s4ICQXgS1ca3fE6NB1xBCdLU1nvgz54bHCETg7gi4qaX87kX3+MSp/J6MJizFnBg2fmDyGBqoehWDMUZrMpkFqb8LAgsZuCqwEtMn4aIduwKVqo+VAGqkWRs8d3zp2eHT+VEEuy0miJYrsSlPrqsiulNaPJNfven0=
Message-ID: <f8e53fb0605100224r298d4799q16c088a5ca9918d5@mail.gmail.com>
Date: Wed, 10 May 2006 11:24:54 +0200
From: "Andrea Galbusera" <gizero@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: custom parallel interface driver
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the context of a PowerPC Linux project I am required to support a
custom parallel interface. The hardware module implementing such
interface lives on a FPGA board connected to the PowerPC by the PCI
bus.

I'm reading developer's docs about the parport subsystem: I'm asking
myself how to use (if possible) all that already available code. Do I
have to develop a new low-level driver using pci and parport
interfaces? Or may I expect to be able to use parport_pc?
Unfortunately I still don't have the hardware available and I'm
evaluating the complexity of this task.

Here are some specifications of the hardware module to support (not
developed by me):
- single unidirectional Centronics-like with control signals interface
- 1K x 8bit FIFO for data

Minimal driver requirements are:
- capability to read data from the FIFO (possiblbly through ususal
device file interfaces and using interrupts)
- capability to read/write control registers of the interface

These may sound as very preliminar questions. In fact, they are! My
kernel development experience is just at the beginning, but I have a
basic knowledge of kernel module writing and I read Rubini's book on
the subject.

Hope somebody can suggest me how to approach the problem, to avoid
re-inventing the wheel...

TIA
