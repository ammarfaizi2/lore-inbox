Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266236AbUIOOgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266236AbUIOOgL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 10:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266252AbUIOOgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 10:36:11 -0400
Received: from webapps.arcom.com ([194.200.159.168]:37381 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S266236AbUIOOgI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 10:36:08 -0400
Subject: Re: udev is too slow creating devices
From: Ian Campbell <icampbell@arcom.com>
To: "Giacomo A. Catenazzi" <cate@debian.org>
Cc: Greg KH <greg@kroah.com>, "Marco d'Itri" <md@Linux.IT>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <414849CE.8080708@debian.org>
References: <41473972.8010104@debian.org>
	 <41474926.8050808@nortelnetworks.com> <20040914195221.GA21691@kroah.com>
	 <414757FD.5050209@pixelized.ch> <20040914213506.GA22637@kroah.com>
	 <20040914214552.GA13879@wonderland.linux.it>
	 <20040914215122.GA22782@kroah.com>
	 <20040914224731.GF3365@dualathlon.random>
	 <20040914230409.GA23474@kroah.com>  <414849CE.8080708@debian.org>
Content-Type: text/plain
Organization: Arcom Control Systems
Message-Id: <1095258966.18800.34.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 15 Sep 2004 15:36:06 +0100
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Sep 2004 14:39:58.0062 (UTC) FILETIME=[DF9E68E0:01C49B31]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 14:55, Giacomo A. Catenazzi wrote:
> Old behaviour (modprobe "waits" for the creation of device):

I wonder if it would be feasible for modprobe (or some other utility) to
have a new option: --wait-for=/dev/something which would wait for the
device node to appear. Perhaps by:
	- some mechanism based on HAL, DBUS, whatever
	- dnotify on /dev/?
	- falling back to spinning and waiting.

The first two sound nice since they avoid spinning and sleeping for a
second at a time, which just adds to the delay.

In addition a timeout of some sort to give an upper bound would seem
like a good idea.

Ian.

-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road, 			Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom	Phone:  +44 (0)1223 411 200

