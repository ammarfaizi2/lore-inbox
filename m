Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275040AbRIYPYq>; Tue, 25 Sep 2001 11:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275041AbRIYPYh>; Tue, 25 Sep 2001 11:24:37 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:22033 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S275040AbRIYPYW>;
	Tue, 25 Sep 2001 11:24:22 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.10 duplicate ISDN symbol
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 26 Sep 2001 01:24:38 +1000
Message-ID: <19657.1001431478@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If both st5481 and tpam are compiled into the kernel, hdlc_decode is a
duplicated symbol.

drivers/isdn/hisax/st5481_hdlc.c:int hdlc_decode(struct hdlc_vars *hdlc, const unsigned char *src,
drivers/isdn/hisax/st5481_usb.c:                        status = hdlc_decode(&in->hdlc_state, ptr, len, &count,

drivers/isdn/tpam/tpam_hdlc.c:DWORD hdlc_decode(BYTE * pbyBuffIn, BYTE * pbyBuffOut, DWORD dwLength)
drivers/isdn/tpam/tpam_commands.c:              templen = hdlc_decode(data, tempdata, len);


