Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWEDLkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWEDLkF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 07:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWEDLkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 07:40:04 -0400
Received: from icarai.midiacom.uff.br ([200.20.10.66]:57235 "EHLO
	MIDIACOM.UFF.BR") by vger.kernel.org with ESMTP id S932083AbWEDLkD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 07:40:03 -0400
Message-ID: <039101c66f6f$9720f3d0$440a14c8@sossego>
From: "Felipe Maya" <fmay@midiacom.uff.br>
To: <linux-kernel@vger.kernel.org>
Subject: ICMP TIMESTAMP
Date: Thu, 4 May 2006 08:40:49 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello people.

I am trying to take data timestamp from an icmp sk_buff, the icmphdr don´t 
have this information.  I feel that timestamp information could be in data 
sk_buff. How take this information?? Is it wrong?

struct tstamp{
      __u32 times[3];
} ;


{
    struct tstamp *tstamp;

    tstamp = (struct tstamp *)(skb->data + skb->hh.iph->ihl * 4 + 
sizeof(struct icmphdr));

}

If it is ok, why can´t i take the data timestamp?

THANKS  for any help.

