Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262418AbTBKPpj>; Tue, 11 Feb 2003 10:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbTBKPpj>; Tue, 11 Feb 2003 10:45:39 -0500
Received: from [212.130.55.83] ([212.130.55.83]:6660 "EHLO smtp.tt.dk")
	by vger.kernel.org with ESMTP id <S262418AbTBKPpi>;
	Tue, 11 Feb 2003 10:45:38 -0500
Message-ID: <E8F83D6D2A6AD3118E0300902786A2050249961F@ntex.tt.dk>
From: "Peter Leif Rasmussen (PLR)" <PLR@tt.dk>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: A change to scsi.h
Date: Tue, 11 Feb 2003 16:54:16 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When looking into:

/usr/src/linux/include/scsi/scsi.h

in kernel revision 2.5.60 I find this in line 200 - 205:

/*
 * ScsiLun: 8 byte LUN.
 */
typedef struct scsi_lun {
        u8 scsi_lun[8];
} ScsiLun;

This produces problems when compiling a package that doesn't know about
'u8'.

In any case shouldn't it be 'uint8_t' so we get:

/*
 * ScsiLun: 8 byte LUN.
 */
typedef struct scsi_lun {
        uint8_t scsi_lun[8];
} ScsiLun;

Just curious from a non-regular on lkml (and I am getting out quick because
of the volume :-)

Thank you very much,

Peter
