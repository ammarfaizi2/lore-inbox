Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269773AbTGKDsP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 23:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269774AbTGKDsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 23:48:15 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:5545 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S269773AbTGKDsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 23:48:14 -0400
Date: Thu, 10 Jul 2003 23:02:33 -0500
Subject: Re: Style question: Should one check for NULL pointers?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linux-kernel@vger.kernel.org
To: "David D. Hagood" <wowbagger@sktc.net>
From: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <3F0DEEA4.5050605@sktc.net>
Message-Id: <7FD4C648-B354-11D7-9801-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, Jul 10, 2003, at 17:54 US/Central, David D. Hagood wrote:
>
> Now, if you have some function that can return an error code, then 
> testing for NULL and returning an error condition is sensible. But if 
> you have no way to report the error, then what good is the test?

Then you add the test, fix your interface to be able to report the 
error, and update callers as necessary... if your code can fail, you 
should be able to report it.

When writing a new function you think returns void, seriously consider 
having it return success instead.

-- 
Hollis Blanchard
IBM Linux Technology Center

