Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbUCCWIp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 17:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbUCCWIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 17:08:45 -0500
Received: from pooh.lsc.hu ([195.56.172.131]:52169 "EHLO pooh.lsc.hu")
	by vger.kernel.org with ESMTP id S261183AbUCCWIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 17:08:09 -0500
Date: Wed, 3 Mar 2004 22:50:46 +0100
From: GCS <gcs@lsc.hu>
To: linux-kernel@vger.kernel.org
Subject: question regarding BSD Security Advisory
Message-ID: <20040303215046.GA4127@lsc.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
X-Operating-System: GNU/Linux
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 I was asked if something like this vulnerability may exists in Linux,
or if is there any precautions for this?
"
Topic: many out-of-sequence TCP packets denial-of-service

I. Background

The Transmission Control Protocol (TCP) of the TCP/IP protocol suite
provides a connection-oriented, reliable, sequence-preserving data
stream service. When network packets making up a TCP stream (``TCP
segments'') are received out-of-sequence, they are maintained in a
reassembly queue by the destination system until they can be re-ordered
and re-assembled.

II. Problem Description

FreeBSD does not limit the number of TCP segments that may be held in a
reassembly queue.

III. Impact

A remote attacker may conduct a low-bandwidth denial-of-service attack
against a machine providing services based on TCP (there are many such
services, including HTTP, SMTP, and FTP). By sending many
out-of-sequence TCP segments, the attacker can cause the target machine
to consume all available memory buffers (``mbufs''), likely leading to
a system crash.
"

Cheers,
GCS
