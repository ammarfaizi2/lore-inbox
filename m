Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264380AbTFPWAt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 18:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264385AbTFPWAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 18:00:48 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:8860 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264380AbTFPWAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 18:00:46 -0400
Message-ID: <3EEE40F1.4030107@us.ibm.com>
Date: Mon, 16 Jun 2003 15:13:05 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Janice M Girouard <janiceg@us.ibm.com>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, stekloff@us.ibm.com,
       girouard@us.ibm.com, lkessler@us.ibm.com, kenistonj@us.ibm.com,
       Jeff Garzik <jgarzik@pobox.com>, davem@redhat.com
Subject: Re: patch for common networking error messages
References: <3EEE28DE.6040808@us.ibm.com>
In-Reply-To: <3EEE28DE.6040808@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Janice M Girouard wrote:

> Below is a patch that demonstrates standard messages for ethernet device 
> drivers.  I would like your feedback on the concept of standard network 
> messages, and any suggestions for messages to include. 

Very useful!  I'd like to see a short note on this in Documentation/
networking..Or perhaps if there is already a RAS best practices
kind of doc or something, add to that? (sorry, havent checked)
But it would be handy for people who wanted to contribute
patches for other drivers.

Essentially, things like some guidelines on classifying some
of those messages, when creating new messages. eg when is
something a state change and when is it a performance event?
I notice some slight ambiguity in your defs..(sorry, very
minor nitpick :)).

I'd certainly like to see messages from the driver when the
card enters/leaves promiscuous mode, as an example of things
we'd like to add...

thanks,
Nivedita


> The intent of the standard message change is to:
> 1) Ensure key events are communicated to user space in a predictable 
> way, enabling automated diagnostic systems or error log analysis,
> 2) Reduce the number of puzzling messages that are logged -- in this 
> case, by replacing them with standard messages, and/or
> 3) Identify the device (or driver name) that is responsible for the error.

