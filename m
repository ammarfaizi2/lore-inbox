Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbTLEMoj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 07:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbTLEMoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 07:44:39 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:43660 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263937AbTLEMoi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 07:44:38 -0500
Message-ID: <3FD07DB5.6090708@namesys.com>
Date: Fri, 05 Dec 2003 15:44:37 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grant Miner <mine0057@mrs.umn.edu>
CC: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: The x Bit Problem
References: <16333.14692.61778.304155@pc7.dolda2000.com>	 <3FCD47C4.50500@ninja.dynup.net> <3FCE39B8.20307@namesys.com>	 <16334.15412.686909.927196@laputa.namesys.com> <1070580817.8344.140.camel@arabia.home.lan> <3FD00086.90607@ninja.dynup.net> <3FD01679.3040007@mrs.umn.edu>
In-Reply-To: <3FD01679.3040007@mrs.umn.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Miner wrote:

> An interesting thing I discovered is that Windows simply ignores the 
> 'x' bit (I should say the Windows equivalent of the 'x' bit, called 
> "traverse folder / execute file"), but there is a policy setting that 
> overrides this attribute.
>
> I know users get tripped up on this a lot in Unix, like when they 
> don't understand why the webserver can't read their public_html 
> directory.  It might be a good option for Linux.
>
>
>
The right solution is to have a separate readdir permission, so that a 
file-directory can be not executable but be listable, and vice-versa.  
The problem comes from overloading the bit and also changing whether 
objects can be simultaneously files and directories.

-- 
Hans


