Return-Path: <linux-kernel-owner+w=401wt.eu-S932707AbWLNND7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932707AbWLNND7 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 08:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932709AbWLNND7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 08:03:59 -0500
Received: from plusavs02.SBG.AC.AT ([141.201.10.77]:33381 "HELO
	plusavs02.sbg.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932707AbWLNND6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 08:03:58 -0500
Subject: Re: get device from file struct
From: Silviu Craciunas <silviu.craciunas@sbg.ac.at>
Reply-To: silviu.craciunas@sbg.ac.at
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061213155346.0a9ecf20@freekitty>
References: <1165850548.30185.18.camel@ThinkPadCK6>
	 <457DA4A0.4060108@ens-lyon.org> <1165914248.30185.41.camel@ThinkPadCK6>
	 <Pine.LNX.4.61.0612131059100.25870@yvahk01.tjqt.qr>
	 <1166006239.30185.66.camel@ThinkPadCK6>
	 <Pine.LNX.4.61.0612131200430.25870@yvahk01.tjqt.qr>
	 <1166012939.30185.77.camel@ThinkPadCK6>
	 <Pine.LNX.4.61.0612132011280.32433@yvahk01.tjqt.qr>
	 <20061213155346.0a9ecf20@freekitty>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 14:03:28 +0100
Message-Id: <1166101408.6186.7.camel@ThinkPadCK6>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Dec 2006 13:03:55.0981 (UTC) FILETIME=[4FE19FD0:01C71F80]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-13 at 15:53 -0800, Stephen Hemminger wrote:
> The connection between file and network device is through many
> layers and there is no direct binding. It could be 0 to N interfaces
> and even be data dependent. 

you mean protocol dependent? yes,it goes trough the layer of the vfs but
I thought there may be a way to get to the struct net_device from the
struct file. You have the dev_base which contains all devices and in the
net_device there is the ifindex which is the unique identifier. I guess
there is no way to know the ifindex directly from a socket struct.

thanks
silviu

