Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129982AbQK3PRN>; Thu, 30 Nov 2000 10:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129990AbQK3PRD>; Thu, 30 Nov 2000 10:17:03 -0500
Received: from mg03.austin.ibm.com ([192.35.232.20]:58007 "EHLO
        mailgate3.austin.ibm.com") by vger.kernel.org with ESMTP
        id <S129982AbQK3PQz>; Thu, 30 Nov 2000 10:16:55 -0500
Message-ID: <3A266895.F522A0E2@austin.ibm.com>
Date: Thu, 30 Nov 2000 08:47:49 -0600
From: Ray Bryant <raybry@austin.ibm.com>
X-Mailer: Mozilla 4.7 [en]C-CCK-MCD NSCPCD47  (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Arnaud Installe <a.installe@ieee.org>
CC: linux-kernel@vger.kernel.org, ainstalle@filepool.com
Subject: Re: high load & poor interactivity on fast thread creation
In-Reply-To: <20001130081443.A8118@bach.iverlek.kotnet.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The IBM implementations of the Java language use native threads --
the result is that every time you do a Java thread creation, you
end up with a new cloned process.  Now this should be pretty fast,
so I am surprised that it stalls like that.  It is possible this
is a scheduler effect.  Do you have a program example you can
share with us?

Also, it is a little old now (by Internet standards) but you 
might take a look at this paper we did at the beginning of 
the year: 
 
http://www-4.ibm.com/software/developer/library/java2/index.html

Arnaud Installe wrote:
> 
> Hello,
> 
> When creating a lot of Java threads per second linux slows down to a
> crawl.  I don't think this happens on NT, probably because NT doesn't
> create new threads as fast as Linux does.
> 
> Is there a way (setting ?) to solve this problem ?  Rate-limit the number
> of threads created ?  The problem occurred on linux 2.2, IBM Java 1.1.8.
> 

-- 

Best Regards,

Ray Bryant
IBM Linux Technology Center
raybry@austin.ibm.com
512-838-8538
http://oss.software.ibm.com/developerworks/opensource/linux

We are Linux. Resistance is an indication that you missed the point.

"...the Right Thing is more important than the amount of flamage you need
to go through to get there"
--Eric S. Raymond
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
