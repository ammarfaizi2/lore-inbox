Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132577AbRD1IZh>; Sat, 28 Apr 2001 04:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132580AbRD1IZ0>; Sat, 28 Apr 2001 04:25:26 -0400
Received: from zeus.kernel.org ([209.10.41.242]:429 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132577AbRD1IZY>;
	Sat, 28 Apr 2001 04:25:24 -0400
Date: Sat, 28 Apr 2001 09:25:05 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: daniel sheltraw <l5gibson@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: busmaster question
Message-ID: <20010428092505.A21488@flint.arm.linux.org.uk>
Mail-Followup-To: Russell King <rmk@flint.arm.linux.org.uk>,
	daniel sheltraw <l5gibson@hotmail.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <F50IEAOeIiGXix4A2Dr00010c13@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <F50IEAOeIiGXix4A2Dr00010c13@hotmail.com>; from l5gibson@hotmail.com on Sat, Apr 28, 2001 at 01:27:30AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2001 at 01:27:30AM -0500, daniel sheltraw wrote:
> I have a busmaster question I am hoping you can help me with.
> If a PCI device is acting as a busmaster and the processor initiates a 
> read/write to another device on the PCI bus while the busmater-device is in 
> control of the bus what happens to the instructions initiated by the 
> processor? Are they never seen by the device that the processor
> is trying to read/write?

The access by the processor is delayed until the PCI arbiter allows the
CPU access to the PCI bus (how long depends on all sorts of things which
I won't go into, but its not necessarily held off until the end of the
busmaster transfer).

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

