Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbUK1NDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbUK1NDt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 08:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbUK1NDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 08:03:49 -0500
Received: from neopsis.com ([213.239.204.14]:37031 "EHLO
	matterhorn.neopsis.com") by vger.kernel.org with ESMTP
	id S261461AbUK1NDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 08:03:44 -0500
Message-ID: <41A9CD78.1050002@dbservice.com>
Date: Sun, 28 Nov 2004 14:07:04 +0100
From: Tomas Carnecky <tom@dbservice.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Miklos Szeredi <miklos@szeredi.hu>, ecki-news2004-05@lina.inka.de,
       linux-kernel@vger.kernel.org
Subject: Re: Problem with ioctl command TCGETS
References: <E1CYMI9-0005PL-00@calista.eckenfels.6bone.ka-ip.net> <E1CYN7z-0001bZ-00@dorka.pomaz.szeredi.hu> <20041128121800.GZ26051@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20041128121800.GZ26051@parcelfarce.linux.theplanet.co.uk>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Neopsis-MailScanner-Information: Please contact the ISP for more information
X-Neopsis-MailScanner: Found to be clean
X-MailScanner-From: tom@dbservice.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Sun, Nov 28, 2004 at 12:22:03PM +0100, Miklos Szeredi wrote:
> 
>>>The set-get is supposed to be used for queries, too? The size of value is
>>>only used for the get case to describe the buffer length in that case?
>>>because otherwise the set-get case may require a short value in and a large
>>>answer structure out.
>>
>>You misunderstand the motivation.  This is to get/set small compact
>>parameters, not huge structures or big data.  Think get/setsockopt().
> 
> 
> Think read(2)/write(2).  We already have several barfbags too many,
> and that includes both ioctl() and setsockopt().  We are stuck with
> them for compatibility reasons, but why the hell would we need yet
> another one?

And what's the option? So without ioctl, how would you reaplace this:
ioctl(cdrom_fd, CDROMEJECT, 0)?

tom
