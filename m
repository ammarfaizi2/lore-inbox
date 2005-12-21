Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbVLUNwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbVLUNwt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 08:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbVLUNwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 08:52:49 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:45015 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP id S932427AbVLUNws
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 08:52:48 -0500
Date: Wed, 21 Dec 2005 14:52:44 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Marc Koschewski <marc@osknowledge.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] conditionally #ifdef-out unused DiB3000M-C/P defs
Message-ID: <20051221135244.GB5611@stiffy.osknowledge.org>
References: <20051221113742.GA5611@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="WfZ7S8PLGjBY9Voh"
Content-Disposition: inline
In-Reply-To: <20051221113742.GA5611@stiffy.osknowledge.org>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.15-rc6-marc-g3e1ec1f4
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This removes the declarations as well.

--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dibusb-remove-dibusb_dib3000-defs-if-not-CONFIG_DVB_USB_DIBUSB_MC.patch"

*** dibusb.h-orig	2005-12-21 14:49:08.000000000 +0100
--- dibusb.h	2005-12-21 14:49:30.000000000 +0100
*************** struct dibusb_state {
*** 104,111 ****
--- 104,113 ----
  
  extern struct i2c_algorithm dibusb_i2c_algo;
  
+ #ifdef CONFIG_DVB_USB_DIBUSB_MC
  extern int dibusb_dib3000mc_frontend_attach(struct dvb_usb_device *);
  extern int dibusb_dib3000mc_tuner_attach (struct dvb_usb_device *);
+ #endif
  
  extern int dibusb_streaming_ctrl(struct dvb_usb_device *, int);
  extern int dibusb_pid_filter(struct dvb_usb_device *, int, u16, int);

--WfZ7S8PLGjBY9Voh--
