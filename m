Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbTESHKz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 03:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbTESHKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 03:10:55 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:35200
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261959AbTESHKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 03:10:55 -0400
Date: Mon, 19 May 2003 03:14:04 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Brad Stockdale <brad@greenepa.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: APIC Errors on a SuperMicro P6DBE
In-Reply-To: <Pine.LNX.4.33.0305181300080.22341-100000@shinji.priderock.org>
Message-ID: <Pine.LNX.4.50.0305190304550.28750-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.33.0305181300080.22341-100000@shinji.priderock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 May 2003, Brad Stockdale wrote:

> APIC error on CPU1: 01(01)
> APIC error on CPU0: 02(02)
> unexpected IRQ trap at vector 1c
> unexpected IRQ trap at vector ac
> unexpected IRQ trap at vector 1c

You're getting a lot of receive and send (checksum and accept) errors and 
as a result invalid vectors being sent to your processors, your APIC bus 
is seeing a lot of data corruption, looks like your motherboard might be 
on it's way out. Try running with 'noapic' to see if it's the IOAPIC or 
local APICs (my bet is on the IOAPIC which would be on your motherboard 
chipset)

	Zwane
-- 
function.linuxpower.ca
