Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbULAGeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbULAGeV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 01:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbULAGeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 01:34:21 -0500
Received: from fachschaft.cup.uni-muenchen.de ([141.84.250.61]:55937 "EHLO
	fachschaft.cup.uni-muenchen.de") by vger.kernel.org with ESMTP
	id S261313AbULAGeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 01:34:18 -0500
Date: Wed, 1 Dec 2004 07:34:22 +0100 (CET)
From: Oliver Neukum <neukum@fachschaft.cup.uni-muenchen.de>
To: Jagadeesh Bhaskar P <jbhaskar@hclinsys.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Query regarding current macro
In-Reply-To: <1101879238.7423.13.camel@myLinux>
Message-ID: <Pine.LNX.4.58.0412010732330.9205@fachschaft.cup.uni-muenchen.de>
References: <1101879238.7423.13.camel@myLinux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Dec 2004, Jagadeesh Bhaskar P wrote:
> 	I have read that both the kernel stack and process descriptor of a
> process is stored in together in an 8KB page. Now the offsets in the
> page should start from all bits 0, rite? So then why masking only the 13
> bits LSB?? What is the significance of keeping that length at 13??

The stack grows downwards on x86. Thus the lowermost stack entry has all
bits set. The length is 13 because 13 corresponds to 8K.

	HTH
		Oliver

