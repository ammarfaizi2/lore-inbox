Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261627AbSKHFss>; Fri, 8 Nov 2002 00:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261640AbSKHFss>; Fri, 8 Nov 2002 00:48:48 -0500
Received: from smtp3.texas.rr.com ([24.93.36.231]:26356 "EHLO
	txsmtp03.texas.rr.com") by vger.kernel.org with ESMTP
	id <S261627AbSKHFsr>; Fri, 8 Nov 2002 00:48:47 -0500
Message-ID: <001401c286e3$410f5fe0$d773a018@OMIT>
From: "omit_ECE" <omit@rice.edu>
To: <linux-kernel@vger.kernel.org>
Subject: A question in decreasing cwnd.
Date: Thu, 7 Nov 2002 23:56:52 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In tcp_input.c, 

/* Decrease cwnd each second ack. */
static void tcp_cwnd_down(struct tcp_opt *tp)
{
     int decr = tp->snd_cwnd_cnt + 1;

     tp->snd_cwnd_cnt = decr&1;
     decr >>= 1;

     if (decr && tp->snd_cwnd > tp->snd_ssthresh/2)
          tp->snd_cwnd -= decr;

     tp->snd_cwnd = min(tp->snd_cwnd, tcp_packets_in_flight(tp)+1);
     tp->snd_cwnd_stamp = tcp_time_stamp;
}

Could anyone explain what does that mean, please?
Thank you.

YuZen
