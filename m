Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261255AbREOScj>; Tue, 15 May 2001 14:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261222AbREOS2x>; Tue, 15 May 2001 14:28:53 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:62859 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S261226AbREOSS1>; Tue, 15 May 2001 14:18:27 -0400
Date: Tue, 15 May 2001 20:18:21 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Alexander Viro <viro@math.psu.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010515201821.B754@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.GSO.4.21.0105151330480.21081-100000@weyl.math.psu.edu> <Pine.LNX.4.10.10105151036490.22038-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.10.10105151036490.22038-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Tue, May 15, 2001 at 10:44:23AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2001 at 10:44:23AM -0700, James Simmons wrote:
> different. I do plan on some day merging drm and fbdev into one interface. So
> I plan to change this behavior. I like to see this interface ioctl-less
> (is their such a word ???). You mmap to alter buffers. Mmap is much more
> flexiable than write for graphics buffers anyways. You use write to pass
> "data" to the driver.

The only problem with mmap(): You cannot know, if the page
changed under you a**.

What would first mmap()ed page of the screen look like, if some
accelerator wrote a line there? Invalidating all mmap()ed pages
for each and every accelerator command would be evil. Forbidding
reads of that page is evil, too.

I have the same problem with DSPs, which like to mmap() some of
their memory into the application, but can alter this memory
every instruction the execute.

mmap() has it's beauties, but ...

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
