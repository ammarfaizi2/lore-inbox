Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262353AbVCVDpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbVCVDpD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 22:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbVCVCYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:24:02 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:37770 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262282AbVCVBeU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:34:20 -0500
Message-Id: <20050322013454.968649000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:23:38 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-frontends-mt352-comments.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 05/48] mt352: Pinnacle 300i comments
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comment preliminary Pinnacle 300i changes to the mt352 driver.

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 mt352.c |    4 ++++
 1 files changed, 4 insertions(+)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/mt352.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/mt352.c	2005-03-21 23:27:59.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/mt352.c	2005-03-22 00:14:46.000000000 +0100
@@ -294,6 +294,8 @@ static int mt352_set_parameters(struct d
 	state->config->pll_set(fe, param, buf+8);
 
 #if 0 /* FIXME: should be catched elsewhere ... */
+	/* this dubious code which helped on some cards does not work for
+	 * the pinnacle 300i */
 	/* Only send the tuning request if the tuner doesn't have the requested
 	 * parameters already set.  Enhances tuning time and prevents stream
 	 * breakup when retuning the same transponder. */
@@ -435,6 +437,8 @@ static int mt352_read_status(struct dvb_
 {
 	struct mt352_state* state = (struct mt352_state*) fe->demodulator_priv;
 #if 1
+	/* the pinnacle 300i loses lock if the STATUS_x registers
+	 * are polled too often... */
 	int val;
 
 	if (0 != mt352_read_register(state, INTERRUPT_0)) {

--

