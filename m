Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbWH2QBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWH2QBz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 12:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWH2QBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 12:01:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:46487 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750977AbWH2QBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 12:01:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g0giD81eUJ1TYblcs81aEAtzjfY7labX5fzmjdk6pGTiohys4U4jmpbh3q9vIRcS3Z7e/Wg43rTm8euvZ3Lz3dYE5w+GKN5lpAOcG9LBEr7Dl+n85mtjuqH9H8V/3A42ITYiS0Wpi8BUZjC21Qh05CNn5tpIx0t/IkKfDbG8ziE=
Message-ID: <a2ebde260608290901w73575e18hffd8a9d6c989f523@mail.gmail.com>
Date: Wed, 30 Aug 2006 00:01:48 +0800
From: "Dong Feng" <middle.fengdong@gmail.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Subject: Re: The 3G (or nG) Kernel Memory Space Offset
Cc: "Andi Kleen" <ak@suse.de>, "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Paul Mackerras" <paulus@samba.org>,
       "Christoph Lameter" <clameter@sgi.com>,
       "David Howells" <dhowells@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0608291634380.16371@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a2ebde260608290715o627c631uca67e5b84b8c0777@mail.gmail.com>
	 <Pine.LNX.4.61.0608291634380.16371@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/8/29, Jan Engelhardt <jengelh@linux01.gwdg.de>:
>
> "0-4G physical memory space" denotes RAM. Since kernelspace is resident, it
> only seems logical to map it to 0G (that is, the start of RAM), because the
> end of RAM can be flexible.
>
> IOW, you cannot map kernelspace to the physical location 0xc0000000 because
> there might not be that much RAM.
>
> (Also note the PCI memory hole which is near the end of the 4G range.)
>
>
> Jan Engelhardt
> --
>


Sorry for my typo. I actually means "0-1G physical memory space." My
question is actually why there is a 3G offset from linear kernel to
physical kernel. Why not simply have kernel memory linear space
located on 0-1G linear address, and therefore the physical kernel and
linear kernel just coincide?

Or perhaps this offset is just some personal favor. Say if the first
kernel designer decided to locate kernel at 2-3G linear address, then
2G offset would have appeared in code. Is this the case?
