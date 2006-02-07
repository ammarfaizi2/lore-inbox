Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965066AbWBGM7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbWBGM7U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 07:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbWBGM7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 07:59:20 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:8242 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S965066AbWBGM7T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 07:59:19 -0500
Message-ID: <43E8999E.8020308@fr.ibm.com>
Date: Tue, 07 Feb 2006 13:59:10 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
CC: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Kirill Korotaev <dev@openvz.org>, arjan@infradead.org,
       frankeh@watson.ibm.com, mrmacman_g4@mac.com, alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: Re: [RFC][PATCH 5/7] VPIDs: vpid/pid conversion in VPID enabled case
References: <43E22B2D.1040607@openvz.org> <43E23398.7090608@openvz.org> <1138899951.29030.30.camel@localhost.localdomain> <20060203105202.GA21819@ms2.inr.ac.ru> <43E35105.3080208@fr.ibm.com> <20060203140229.GA16266@ms2.inr.ac.ru> <43E38D40.3030003@fr.ibm.com> <20060206094843.GA6013@ms2.inr.ac.ru> <20060206145104.GB11887@sergelap.austin.ibm.com> <20060206155101.GA22522@ms2.inr.ac.ru> <43E86C73.2070608@fr.ibm.com> <43E88823.3060203@sw.ru>
In-Reply-To: <43E88823.3060203@sw.ru>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:

>> I think the "child reaper" question is not related to the (container,pid)
>> approach or the vpid approach. This is another question on who is the
>> parent of a container and how does it behaves.
> 
> it is related. How reaps the last process in container when it dies?
> what does waitpid() return?

The current init sigchild handler does that very well and is also pid
friendly :)

>> We have choosen to first follow a simple "path", complete pid isolation
>> being the main constraint : a container is created by exec'ing a
>> process in it.
> 
> Why to exec? It was asked already some times...

Just restarting the thread on how a container should be created ...

C.
