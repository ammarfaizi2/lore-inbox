Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262667AbUKEMrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbUKEMrF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 07:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbUKEMrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 07:47:05 -0500
Received: from mail.gmx.de ([213.165.64.20]:31696 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262667AbUKEMrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 07:47:01 -0500
X-Authenticated: #21910825
Message-ID: <418B7632.4000100@gmx.net>
Date: Fri, 05 Nov 2004 13:46:42 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6) Gecko/20040114
X-Accept-Language: de, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [RFC] randomized major and minor numbers
References: <418A36CD.2030600@gmx.net> <20041105085003.GA26457@kroah.com>
In-Reply-To: <20041105085003.GA26457@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Nov 04, 2004 at 03:03:57PM +0100, Carl-Daniel Hailfinger wrote:
> 
>>Hi,
>>
>>IIRC it was debated during 2.5 development to make the kernel
>>hand out randomized major/minor numbers to better test handling
>>of dynamic major/minor numbers. Is there a patch available
>>to test?
> 
> 
> Not yet, care to make one?  :)

Will do once I have some time.

> Note, any such change, would only be a development aid, and not a
> requirement by any means.

Of course. My intention was to have this available as a testing harness,
possibly configurable under the kernel debug options (not strictly kernel
debugging, but it can help improve the kernel).

Right now I'm not sure whether it is possible to have different drivers
serving the same block major. IIRC there was/is such a limitation, so I
would have to create a new "disk" driver first which would serve as sort
of a multiplexing driver for all block device drivers.


On another note, Joel Becker and I had a private discussion about my
suggested naming scheme and I have to agree with him that it was
suboptimal. However, my main intention was to go forward with a generic
disk access interface and not start a flamewar about naming. Naming is
policy and I'd rather leave that decision to somebody else.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
