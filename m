Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318176AbSHMPsS>; Tue, 13 Aug 2002 11:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318186AbSHMPsS>; Tue, 13 Aug 2002 11:48:18 -0400
Received: from air-2.osdl.org ([65.172.181.6]:7173 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S318176AbSHMPsR>;
	Tue, 13 Aug 2002 11:48:17 -0400
Date: Tue, 13 Aug 2002 08:48:28 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
       Erik Andersen <andersen@codepoet.org>
Subject: Re: [PATCH] cdrom sane fallback vs 2.4.20-pre1
In-Reply-To: <200208131413.g7DEDd502174@localhost.localdomain>
Message-ID: <Pine.LNX.4.33L2.0208130847380.5175-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2002, James Bottomley wrote:

| > > -             if (ret) {
| > > +             if (ret && sense.sense_key==0x05 && sense.asc==0x20 && sense.ascq==0x00) {
| >
| > Do you really need to hardcode this values ?
|
| We have no #defines for the asc and ascq codes (they are interpreted in
| constants.c but the values are hardcoded in there too).  There is a #define
| for sense_key 0x05 as ILLEGAL_REQUEST in scsi/scsi.h, but these #defines have
| annoyed a lot of people by being rather namespace polluting.

and that's precisely the wrong attitude IMO.

I was glad to see that Marcelo asked about the hardcoded values.
They hurt.

-- 
~Randy

