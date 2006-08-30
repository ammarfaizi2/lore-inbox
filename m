Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbWH3Ekh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbWH3Ekh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 00:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWH3Ekh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 00:40:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:56562 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751389AbWH3Ekh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 00:40:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=eGIL+5hmQd8b/PI97XsEkqV/zAghGlipy5bIPibAvoNvkzOnesheq5zUSgvQNwgFONTtXJSmWPPpSdPB6FOY5m7Wjf1BPLHZGVFguq+T8jIPKt1H0q1+3FwftfcpMQfM1B7HXFno9Zii9ae3Gm23HWtcLjDGQXaCpvDNX1QshMg=
Message-ID: <489ecd0c0608292140m483bba2fqa300b55c5f4acf26@mail.gmail.com>
Date: Wed, 30 Aug 2006 12:40:35 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: linux-kernel@vger.kernel.org, dbrownell@users.sourceforge.net,
       spi-devel-general@lists.sourceforge.net
Subject: [Patch] Add spi full duplex mode transfer support
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_36961_15509105.1156912835626"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_36961_15509105.1156912835626
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

   To enable full duplex mode spi transfer in Blackfin spi master
driver, I need an extra field in spi_transfer structure. Attached the
right format patch.

Signed-off-by: Luke Yang <luke.adi@gmail.com>

 spi.h |    1 +
 1 files changed, 1 insertion(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index c8bb680..99816eb 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -331,6 +331,7 @@ struct spi_transfer {
        dma_addr_t      rx_dma;

        unsigned        cs_change:1;
+       unsigned        is_duplex:1;
        u8              bits_per_word;
        u16             delay_usecs;
        u32             speed_hz;

-- 
Best regards,
Luke Yang
luke.adi@gmail.com

------=_Part_36961_15509105.1156912835626
Content-Type: text/x-patch; name=spi_full_duplex.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_erh7vbpd
Content-Disposition: attachment; filename="spi_full_duplex.patch"

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc3BpL3NwaS5oIGIvaW5jbHVkZS9saW51eC9zcGkv
c3BpLmgKaW5kZXggYzhiYjY4MC4uOTk4MTZlYiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9z
cGkvc3BpLmgKKysrIGIvaW5jbHVkZS9saW51eC9zcGkvc3BpLmgKQEAgLTMzMSw2ICszMzEsNyBA
QCBzdHJ1Y3Qgc3BpX3RyYW5zZmVyIHsKIAlkbWFfYWRkcl90CXJ4X2RtYTsKIAogCXVuc2lnbmVk
CWNzX2NoYW5nZToxOworCXVuc2lnbmVkICAgICAgICBpc19kdXBsZXg6MTsKIAl1OAkJYml0c19w
ZXJfd29yZDsKIAl1MTYJCWRlbGF5X3VzZWNzOwogCXUzMgkJc3BlZWRfaHo7Cg==
------=_Part_36961_15509105.1156912835626--
