Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262324AbSI1U0k>; Sat, 28 Sep 2002 16:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262325AbSI1U0j>; Sat, 28 Sep 2002 16:26:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19985 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262324AbSI1U0j>;
	Sat, 28 Sep 2002 16:26:39 -0400
Message-ID: <3D9611A0.3080905@pobox.com>
Date: Sat, 28 Sep 2002 16:31:28 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Don Cohen <don-temp5298413@isis.cs3-inc.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: reading /proc files larger than one buffer
References: <200209282010.g8SKASL01208@isis.cs3-inc.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don Cohen wrote:
> If you follow the directions in Documentation/DocBook/procfs-guide.tmpl
> then your file read will not work correctly unless the whole file is
> read in one call.
> 
> After examining (and experimenting with) fs/proc/generic.c I now see
> what you have to do: in addition to writing bytes in the page
> parameter, setting eof as appropriate and returning the number of
> bytes written, you also need to do:
>  *start = page;
> At minimum the documentation should be corrected.


There is a new seq_xxx API that covers this quite well... the 
documentation should be updated to include that, especially.  seq_xxx 
should take care of a large number of complex or potentially-large 
procfs output.

Any change you would be interested in updating the docs?  ;-)

