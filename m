Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161274AbWASImD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161274AbWASImD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 03:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161275AbWASImD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 03:42:03 -0500
Received: from xizor.is.scarlet.be ([193.74.71.21]:24295 "EHLO
	xizor.is.scarlet.be") by vger.kernel.org with ESMTP
	id S1161274AbWASImB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 03:42:01 -0500
Date: Thu, 19 Jan 2006 09:41:54 +0100
Message-Id: <ITC05V$CEEE7E19B7F22BB040EA06068471D72B@scarlet.be>
Subject: 2.6.16-rc1-git1 -- Build error "make: *** [include/linux/version.h] 
	Error 2"
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
From: "" <joel.soete@tiscali.be>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
X-XaM3-API-Version: 4.1 (B54)
X-type: 0
X-SenderIP: 57.67.177.33
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles,

I read you experiment the same pb, as it makes me lost my previous day ;-(.

As far as I can investigate, it came from a pb with 'make mrproper' which (i
don't know yet when/how) rm a char dev namely /dev/null which is then replaced
by a ordinary file?

Anyway you have to 'rm /dev/null' and recreate the char dev:
e.g. with a debian install
# cd /dev
# ./MAKEDEV null 

Joel

---------------------------------------------------------------
A free anti-spam and anti-virus filter on all Scarlet mailboxes
More info on http://www.scarlet.be/

