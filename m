Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965143AbWECKaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbWECKaS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 06:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965144AbWECKaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 06:30:17 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:16067 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965143AbWECKaQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 06:30:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HKGWKr5U04BF/eFE7ScmjhQR81+r7lo+kL5asaRaLyN5QVlB2lto2wJXKX3alk8p/Qgv8Q5CE/TtMwAVZ7jviAZulLfjV08dWjaVRKKA1cYOhLJ1lSrzPak51Xb4fBGhKPTE49DZ5yA7/Bc1x8pHURNXeCb4+179+C2OGePrgZk=
Message-ID: <3634de740605030330t1e060362ibff0e247bfb805e5@mail.gmail.com>
Date: Wed, 3 May 2006 03:30:14 -0700
From: Maximus <john.maximus@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: sdio - ocr confusions
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  im trying to develop and sdio driver modifying the existing SD card driver.
  Im using an OMAP processor and a Wifi SDIO Card.

  I have send CMD 5 to get the OCR.

  i do get the EOC Status bit set.

  I do get the response resp[0] => 0x10fff000   (Contents of RSP6 & RSP7)


  According to this -> ocr => 0xfff000 (right most 24 bits)
                                mem present => 0
                                No of IO functions => 1

  I am using a Wifi SDIO Card - am not sure if these values are correct?.

  Am i doing something wrong here?


  I understand from the SDIO specs that only one of the bits (0-24) must be set.

  How do u interpreset an ocr of 0xfff000 ?.



  #define MMC_RSP_R4  (MMC_RSP_SHORT|MMC_RSP_CRC)
  #define SDIO_IO_SEND_OP_COND   (5)

    cmd.opcode = SDIO_IO_SEND_OP_COND ;
    cmd.arg = 0;
    cards.flags = MMC_RSP_R4

  Is this wrong?


Regards,
Jo

MMC1: set_ios: clock 0Hz busmode 1 powermode 0 Vdd 0.00
MMC1: set_ios: clock 0Hz busmode 1 powermode 0 Vdd 0.00
MMC1: set_ios: clock 400000Hz busmode 1 powermode 1 Vdd 0.21
MMC1: set_ios: clock 400000Hz busmode 1 powermode 1 Vdd 0.21
MMC1: set_ios: clock 400000Hz busmode 1 powermode 2 Vdd 0.21
MMC1: set_ios: clock 400000Hz busmode 1 powermode 2 Vdd 0.21

MMC: starting cmd 05 arg 00000000 flags 00000009
MMC1: CMD5, argument 0x00000000, 32-bit response, CRC
MMC IRQ 0001 (CMD 5): EOC
MMC1: Response 10fff000
MMC1: End request, err 0
MMC: req done (05): 0: 10fff000 00000000 00000000 00000000
  MC1: set_ios: clock 0Hz busmode 1 powermode 0 Vdd 0.00
MMC1: set_ios: clock 0Hz busmode 1 powermode 0 Vdd 0.00
