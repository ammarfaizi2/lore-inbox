Return-Path: <linux-kernel-owner+w=401wt.eu-S932889AbWLNSq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932889AbWLNSq4 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 13:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932890AbWLNSq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 13:46:56 -0500
Received: from smtp.osdl.org ([65.172.181.25]:47254 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932889AbWLNSqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 13:46:55 -0500
Date: Thu, 14 Dec 2006 10:45:18 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: silviu.craciunas@sbg.ac.at
Cc: linux-kernel@vger.kernel.org
Subject: Re: get device from file struct
Message-ID: <20061214104518.6ad2cc4c@freekitty>
In-Reply-To: <1166101408.6186.7.camel@ThinkPadCK6>
References: <1165850548.30185.18.camel@ThinkPadCK6>
	<457DA4A0.4060108@ens-lyon.org>
	<1165914248.30185.41.camel@ThinkPadCK6>
	<Pine.LNX.4.61.0612131059100.25870@yvahk01.tjqt.qr>
	<1166006239.30185.66.camel@ThinkPadCK6>
	<Pine.LNX.4.61.0612131200430.25870@yvahk01.tjqt.qr>
	<1166012939.30185.77.camel@ThinkPadCK6>
	<Pine.LNX.4.61.0612132011280.32433@yvahk01.tjqt.qr>
	<20061213155346.0a9ecf20@freekitty>
	<1166101408.6186.7.camel@ThinkPadCK6>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2006 14:03:28 +0100
Silviu Craciunas <silviu.craciunas@sbg.ac.at> wrote:

> On Wed, 2006-12-13 at 15:53 -0800, Stephen Hemminger wrote:
> > The connection between file and network device is through many
> > layers and there is no direct binding. It could be 0 to N interfaces
> > and even be data dependent. 
> 
> you mean protocol dependent? yes,it goes trough the layer of the vfs but
> I thought there may be a way to get to the struct net_device from the
> struct file. You have the dev_base which contains all devices and in the
> net_device there is the ifindex which is the unique identifier. I guess
> there is no way to know the ifindex directly from a socket struct.
> 
> thanks
> silviu
> 

You can have things like netfilter and traffic classifiers that look
at packet.

-- 
Stephen Hemminger <shemminger@osdl.org>
