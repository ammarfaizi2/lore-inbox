Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbTK1J4b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 04:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbTK1J4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 04:56:31 -0500
Received: from compaq.com ([161.114.1.206]:35846 "EHLO
	ztxmail02.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S262099AbTK1J43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 04:56:29 -0500
Message-ID: <3FC71C97.8030104@mailandnews.com>
Date: Fri, 28 Nov 2003 15:29:51 +0530
From: Raj <raju@mailandnews.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Strange behavior observed w.r.t 'su' command
References: <20031128093929.13486.qmail@web40909.mail.yahoo.com>
In-Reply-To: <20031128093929.13486.qmail@web40909.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One more observation:

This time i wrote two shell functions, one for the user and another for 
root. I placed them in the .bash_profile

for root
z()
{
    touch /tmp/createdbyroot
}

for user
z()
{
    touch /tmp/createdbyuser
}

I then reproduced the problem, and during the alternation of the 
prompts, when i was on the user prompt, i ran 'whoami' and it showed me 
as a normal user. Then i ran 'z'. I expected the filename in /tmp to be 
'createdbyuser' but it is actually 'createdbyroot' !!!

/Raj

