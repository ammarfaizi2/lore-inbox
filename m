Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbTE2OFu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 10:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbTE2OFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 10:05:50 -0400
Received: from A17-250-248-97.apple.com ([17.250.248.97]:59611 "EHLO
	smtpout.mac.com") by vger.kernel.org with ESMTP id S262254AbTE2OFt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 10:05:49 -0400
Date: Fri, 30 May 2003 00:19:05 +1000
Subject: Re: buffer_head.b_bsize type
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
To: viro@parcelfarce.linux.theplanet.co.uk
From: Stewart Smith <stewartsmith@mac.com>
In-Reply-To: <20030529111517.GP14138@parcelfarce.linux.theplanet.co.uk>
Message-Id: <80FB28EB-91E0-11D7-9488-00039346F142@mac.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, May 29, 2003, at 09:15  PM, 
viro@parcelfarce.linux.theplanet.co.uk wrote:
>> Could we go the other way and make all users of b_size use unsigned?
>
> Who the hell cares?  Size of buffer does not exceed the page size.
> Unless you can show a platform with 2Gb pages...

I would argue the same that the size of a buffer should never be able 
to be negative and the structure says this but the rest of the code 
does not. (Theoretically) if a negative size was asked for, then we'd 
actually try to allocate a large amount of memory for the buffer, 
possibly causing badness somewhere along the line.

Any maybe we shouldn't make it too hard for archs with 2GB pages :) 
It'll probably happen in 20 years. :)

------------------------------
Stewart Smith
stewartsmith@mac.com
Ph: +61 4 3884 4332
ICQ: 6734154
http://www.flamingspork.com/       http://www.linux.org.au

