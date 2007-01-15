Return-Path: <linux-kernel-owner+w=401wt.eu-S932222AbXAOLK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbXAOLK2 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 06:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbXAOLK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 06:10:28 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:47404 "EHLO
	smtp-out.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932222AbXAOLK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 06:10:28 -0500
From: Oliver Neukum <oliver@neukum.org>
To: icxcnika@mar.tar.cc, linux-usb-devel@lists.sourceforge.net,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] 2.6.20-rc4: usb somehow broken
Date: Mon, 15 Jan 2007 12:10:49 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0701141418290.24969-100000@netrider.rowland.org> <Pine.LNX.4.64.0701141945010.14767@server.willdawg>
In-Reply-To: <Pine.LNX.4.64.0701141945010.14767@server.willdawg>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701151210.49495.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 14. Januar 2007 20:47 schrieb icxcnika@mar.tar.cc:
> > Can anyone suggest another approach?
> >
> > Alan Stern
> 
> Just a thought, you could use both a blacklist approach, and a module 
> paramater, or something in sysfs, to allow specifying devices that won't 
> be suspend and resume compatible.

Upon further thought, a module parameter won't do as the problem
will arise without a driver loaded. A sysfs parameter turns the whole
affair into a race condition. Will you set the guard parameter before the
autosuspend logic strikes?
Unfortunately this leaves only the least attractive solution.

	Regards
		Oliver
