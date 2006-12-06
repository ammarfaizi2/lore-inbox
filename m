Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760277AbWLFHAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760277AbWLFHAS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 02:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760279AbWLFHAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 02:00:18 -0500
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:23124 "HELO
	smtp114.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1760277AbWLFHAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 02:00:16 -0500
X-YMail-OSG: OdGANuYVM1knM.H4MMx9yO1W3JYgw5FmYG.dHzMv1n1vvqlr7hMgm3i5_I_iNpCeTfbEpnZApGAMnC7n9DIwTupMSO_cs6jVhJdqFh5NfGKrASAeyaLcLZOGfeqp7d_6vOCKPFDZ7lJ8yg--
Date: Tue, 5 Dec 2006 23:00:14 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: gcc@gcc.gnu.org, GNU C Library <libc-alpha@sources.redhat.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Change x86 prefix order
Message-ID: <20061206070014.GA535@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On x86, the order of prefix SEG_PREFIX, ADDR_PREFIX, DATA_PREFIX and
LOCKREP_PREFIX isn't fixed. Currently, gas generates

LOCKREP_PREFIX ADDR_PREFIX DATA_PREFIX SEG_PREFIX

I will check in a patch:

http://sourceware.org/ml/binutils/2006-12/msg00054.html

tomorrow and change gas to generate

SEG_PREFIX ADDR_PREFIX DATA_PREFIX LOCKREP_PREFIX


H.J.
