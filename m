Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbUCJQaQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 11:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbUCJQaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 11:30:16 -0500
Received: from viola.ocn.ne.jp ([210.190.142.170]:13304 "EHLO
	smtp.viola.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S262678AbUCJQaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 11:30:09 -0500
Message-ID: <00b501c406bd$47e48240$0d02010a@BoomBoomBloom>
From: "hiro" <nishirotaka@viola.ocn.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: SO_SNDTIMEO SO_RCVTIMEO[2.4.x]
Date: Thu, 11 Mar 2004 01:32:24 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

setsockopt option, SO_SNDTIMEO and SO_RCVTIMEO implemented?
in linux/net/core/sock.c sock_setsockopt follow

                case SO_RCVTIMEO:
                        ret = sock_set_timeout(&sk->rcvtimeo, optval,
optlen);
                        break;

                case SO_SNDTIMEO:
                        ret = sock_set_timeout(&sk->sndtimeo, optval,
optlen);
                        break;

timeval is setting socket buffer
but man 7 socket is ...

       SO_RCVTIMEO and SO_SNDTIMEO
              Specify the sending or receiving timeouts until reporting
anerror.   They  are
              fixed  to  a  protocol  specific setting in Linux and cannotbe
read or written.
              Their functionality can be emulated using alarm(2) or
setitimer(2).

man 7 scoket told me socket timeout can't change!!
Which is ture?

