Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272956AbTHFAB2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 20:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272957AbTHFAB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 20:01:28 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:47042 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S272956AbTHFAB1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 20:01:27 -0400
From: Lev Makhlis <mlev@despammed.com>
To: linux-kernel@vger.kernel.org
Subject: TcpOutSegs in tcp_mib not RFC1213 compliant?
Date: Tue, 5 Aug 2003 20:01:22 -0400
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308052001.22259.mlev@despammed.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>From looking at net/ipv4/tcp_output.c, TcpOutSegs counts all
outgoing packets, including pure retransmits.  This seems
to contradict RFC 1213 (MIB-II):

          tcpOutSegs OBJECT-TYPE
              SYNTAX  Counter
              ACCESS  read-only
              STATUS  mandatory

              DESCRIPTION
                      "The total number of segments sent, including
                      those on current connections but excluding those
                      containing only retransmitted octets."
              ::= { tcp 11 }

Is that intentional or an oversight?

Lev

