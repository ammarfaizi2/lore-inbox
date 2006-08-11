Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWHKABn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWHKABn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 20:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWHKABm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 20:01:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:62377 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932136AbWHKABm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 20:01:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NPCJArTrX7NHiFfhPkp4jpCMhOgYWZwJwdc1dXN9oXnZHmvJ/SClYv+GqkqPYLZJx8yOYREjML6xKS+tq4ds2XRjUWR62GikdT2VozBj18aSxmwrZN2PoPBxPoOIPAAaQDmJgVVIMxEpxZ3fus08V2jbu279vj2M4gy769MKkEE=
Message-ID: <41840b750608101701o6e2292e8r20c2fdf2216e4056@mail.gmail.com>
Date: Fri, 11 Aug 2006 03:01:39 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: [PATCH 00/12] ThinkPad embedded controller and hdaps drivers (version 2)
Cc: "Greg KH" <gregkh@suse.de>, "Andrew Morton" <akpm@osdl.org>,
       "Robert Love" <rlove@rlove.org>, linux-kernel@vger.kernel.org,
       "Pavel Machek" <pavel@suse.cz>, hdaps-devel@lists.sourceforge.net
In-Reply-To: <20060810230545.84bbcb45.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1155203330179-git-send-email-multinymous@gmail.com>
	 <acdcfe7e0608100646s411f57ccse54db9fe3cfde3fb@mail.gmail.com>
	 <20060810131820.23f00680.akpm@osdl.org>
	 <20060810203736.GA15208@suse.de>
	 <20060810230545.84bbcb45.khali@linux-fr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On 8/11/06, Jean Delvare <khali@linux-fr.org> wrote:
> I would
> ask for an explanation of how that person got access to information
> about the HDAPS which even the original author of the driver didn't
> know about. And I would ask for proofs of that explanation.
> All this is very unlikely to happen as I understand it,

The mystery is rather simpler and less sinister than you imply, and
I've already explained it before (e.g., in the first few lines of the
code you say you don't want to read). But let me explain again in
detail:

The original author of the APS spec [1] reversed-engineered the
Windows driver, so he only saw what that driver was doing under
nominal conditions. Jesper Juhl, the original author the mainline
hdaps code, closely followed that spec (a prudent thing to do if you
know nothing about the hardware), so was subject to the same
limitation. However, once someone took apart his ThinkPad and
uncovered the embedded controller chip [2], we got the underlying EC
hardware specs [3]. Contrasting the LPC protocol in [3] with the APS
spec [1] and mainline code showed they're indeed very similar,
confirming the guess (and giving us the IO port offsets). This was the
main breakthrough. The rest is detailed in my previous post.

  Shem

[1]http://www.almaden.ibm.com/cs/people/marksmith/tpaps.html
[2]http://thinkwiki.org/wiki/Image:T43p-H8S2161.jpg
[3]http://documentation.renesas.com/eng/products/mpumcu/rej09b0300_2140bhm.pdf
