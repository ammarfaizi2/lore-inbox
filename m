Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261725AbSJUWJy>; Mon, 21 Oct 2002 18:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261726AbSJUWJy>; Mon, 21 Oct 2002 18:09:54 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:22198 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261725AbSJUWJy>; Mon, 21 Oct 2002 18:09:54 -0400
Subject: RE: 2.5.44 compile problem: MegaRAID driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matt_Domsch@Dell.com
Cc: andmike@us.ibm.com, cliffw@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-megaraid-devel@Dell.com
In-Reply-To: <20BF5713E14D5B48AA289F72BD372D68C1EA2E@AUSXMPC122.aus.amer.dell.com>
References: <20BF5713E14D5B48AA289F72BD372D68C1EA2E@AUSXMPC122.aus.amer.dell.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 23:31:47 +0100
Message-Id: <1035239507.27309.259.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-21 at 23:10, Matt_Domsch@Dell.com wrote:
> The host reordering is to solve the same problem that EDD helps us solve now
> - it makes sure that in systems with megaraid adapters that also have BIOS
> enabled (thus have the bootable logical drive on that card) that it shows up

You can fix the ordering up still if you want within cards of a given
driver type. i2o does this to get its bios boot volume first. Just do it
by probing your devices, then registering them in the order you want,
not by mashing the list

