Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266388AbUAHU0P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 15:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266389AbUAHU0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 15:26:15 -0500
Received: from ns.clanhk.org ([69.93.101.154]:40833 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S266388AbUAHU0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 15:26:12 -0500
Message-ID: <3FFD6741.3000300@clanhk.org>
Date: Thu, 08 Jan 2004 14:20:49 +0000
From: "J. Ryan Earl" <heretic@clanhk.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: Performance drop 2.6.0-test7 -> 2.6.1-rc2
References: <20040107023042.710ebff3.akpm@osdl.org>	<20040107215240.GA768@frodo>	<20040108105427.E20265@fi.muni.cz>	<20040108021637.15d1b33a.akpm@osdl.org>	<20040108112547.G20265@fi.muni.cz> <20040108023356.00db9dec.akpm@osdl.org>
In-Reply-To: <20040108023356.00db9dec.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Jan Kasprzak <kas@informatics.muni.cz> wrote:
>  
>
>>Andrew Morton wrote:
>>: Jan Kasprzak <kas@informatics.muni.cz> wrote:
>>: >  - this is reliable: repeated boot back to 2.6.1-rc2 makes the problem
>>: >  	appear again (high load, system slow has hell), booting back
>>: >  	to -test7 makes it disappear.
>>    
>>

I was about to post something about this as well.  I recently went to 
upgrade a production server in a datacenter.  I wanted to use a 2.6 
kernel: I tried 2.6.0-mm1 and 2.6.1-rc1-mm1--needed the siimage 
patches.  User space CPU usage was WAY high.  I'm talking 2x or more 
than normal, though sys time was low.  Processes that had no connections 
and should have used 0% CPU were using 1% CPU when no one was even 
connected.  And a loaded process which should only use ~25% CPU was 
using 60% CPU.  Very unresponsive, very slow.  I ended up staying with a 
2.4.23 kernel with my required patches.  I didn't try any other 2.6 
kernels, so I can't say which version this problem appeared in, but I 
DEFINITELY noticed it and it is repeatable.  I didn't have time to test 
further.

-ryan


