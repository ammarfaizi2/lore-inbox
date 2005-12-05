Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbVLEP6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbVLEP6a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 10:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbVLEP6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 10:58:30 -0500
Received: from quechua.inka.de ([193.197.184.2]:63423 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1751377AbVLEP63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 10:58:29 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: /proc/stat [Subject changed]
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <AF41465C-AE05-4077-A52F-CA08796B925A@2sheds.de>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1EjIjU-0003Lr-00@calista.inka.de>
Date: Mon, 05 Dec 2005 16:58:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <AF41465C-AE05-4077-A52F-CA08796B925A@2sheds.de> you wrote:
> I would greatly appreciate it if anyone in the know, could spare the  
> two minutes
> to have a look at my question below, or tell me where I should look  
> to get it
> answered.

the files in proc are all to some degree atomic to some not. You will have
to look into the source for the specific file to see the details. For
smaller files if they fit into a single 4k page you have good chances.
Bigger files can cause all kind of trouble. (most often you miss new
records)

In case of stat the readings should be consistent within itself since all
cpu lines fit into a single page.

Gruss
Bernd
