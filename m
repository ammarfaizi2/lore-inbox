Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWGDM3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWGDM3e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 08:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWGDM3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 08:29:34 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:33446 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932239AbWGDM3d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 08:29:33 -0400
Message-ID: <44AA5F28.9040109@fr.ibm.com>
Date: Tue, 04 Jul 2006 14:29:28 +0200
From: Daniel Lezcano <dlezcano@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrey Savochkin <saw@swsoft.com>
CC: Sam Vilain <sam@vilain.net>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, hadi@cyberus.ca,
       Herbert Poetzl <herbert@13thfloor.at>, Alexey Kuznetsov <alexey@sw.ru>,
       viro@ftp.linux.org.uk, devel@openvz.org, dev@sw.ru,
       Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, Ben Greear <greearb@candelatech.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: strict isolation of net interfaces
References: <20060627225213.GB2612@MAIL.13thfloor.at> <1151449973.24103.51.camel@localhost.localdomain> <20060627234210.GA1598@ms2.inr.ac.ru> <m1mzbyj6ft.fsf@ebiederm.dsl.xmission.com> <20060628133640.GB5088@MAIL.13thfloor.at> <1151502803.5203.101.camel@jzny2> <44A44124.5010602@vilain.net> <44A450D1.2030405@fr.ibm.com> <20060630023947.GA24726@sergelap.austin.ibm.com> <44A49121.4050004@vilain.net> <20060703185350.A16826@castle.nmd.msu.ru>
In-Reply-To: <20060703185350.A16826@castle.nmd.msu.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin wrote:
> 
> I still can't completely understand your direction of thoughts.
> Could you elaborate on IP address assignment in your diagram, please?  For
> example, guest0 wants 127.0.0.1 and 192.168.0.1 addresses on its lo
> interface, and 10.1.1.1 on its eth0 interface.
> Does this diagram assume any local IP addresses on v* interfaces in the
> "host"?
> 
> And the second question.
> Are vlo0, veth0, etc. devices supposed to have hard_xmit routines?


Andrey,

some people are interested by a network full isolation/virtualization 
like you did with the layer 2 isolation and some other people are 
interested by a light network isolation done at the layer 3. This one is 
intended to implement "application container" aka "lightweight container".

In the case of a layer 3 isolation, the network interface is not totally 
isolated and the debate here is to find a way to have something 
intuitive to manage the network devices.

IHMO, all the discussion we had convinced me of the needs to have the 
possibility to choose between a layer 2 or a layer 3 isolation.

If it is ok for you, we can collaborate to merge the two solutions in 
one. I will focus on layer 3 isolation and you on the layer 2.

Regards

   - Daniel
