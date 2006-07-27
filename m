Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbWG0PmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbWG0PmZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 11:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbWG0PmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 11:42:25 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:13992 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S932437AbWG0PmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 11:42:24 -0400
Message-Id: <44C8FB44.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Thu, 27 Jul 2006 17:43:32 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "gmu 2k6" <gmu2006@gmail.com>
Cc: <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix Intel RNG detection
References: <44C8BE63.76E4.0078.0@novell.com>
 <f96157c40607270818p2cfec277x7eaf8eb2f3767268@mail.gmail.com>
 <f96157c40607270835l34cd0de1w8c8a0d95ba8ee39f@mail.gmail.com>
In-Reply-To: <f96157c40607270835l34cd0de1w8c8a0d95ba8ee39f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

># dmesg | grep rng
>intel_rng: FWH not detected
>
>looks like this ProLiant box with the ICH5 chip has no usable RNG
>included, or should it?

A configuration like this is what actually motivated me to write the
patch. You need to remember that the RNG doesn't live in the ICH, but in
the FWH (which is a different chip not showing up as a separate device
anywhere) with only some access parameters being configured via the LPC
device inside the ICH.

Jan
