Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130498AbRCIMJe>; Fri, 9 Mar 2001 07:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130497AbRCIMJY>; Fri, 9 Mar 2001 07:09:24 -0500
Received: from adsl-204-0-249-112.corp.se.verio.net ([204.0.249.112]:19442
	"EHLO tabby.cats-chateau.net") by vger.kernel.org with ESMTP
	id <S130491AbRCIMJT>; Fri, 9 Mar 2001 07:09:19 -0500
From: Jesse Pollard <jesse@cats-chateau.net>
Reply-To: jesse@cats-chateau.net
To: Graham Murray <graham@webwayone.com>, linux-kernel@vger.kernel.org
Subject: Re: Microsoft begining to open source Windows 2000?
Date: Fri, 9 Mar 2001 06:05:20 -0600
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.32.0103081124210.9614-100000@viper.haque.net> <m3g0gnfcol.fsf@gmlinux.webwayone.co.uk>
In-Reply-To: <m3g0gnfcol.fsf@gmlinux.webwayone.co.uk>
MIME-Version: 1.0
Message-Id: <01030906084600.09523@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Mar 2001, Graham Murray wrote:
>"Mohammad A. Haque" <mhaque@haque.net> writes:
>
>> making a patch means you've modfied the source which you are not allowed
>> to do. The most you can do is report the bug through normal channels
>> (you dont even have priority in reporting bugs since you have the code).
>
>Does making a patch necessarily require modifying the source code?
>Back in my days as a mainframe systems programmer (ICL VME/B), most OS
>patches were made to the binary image, either in the file or to the
>loaded virtual memory image.

Nearly always. The problem is that the patch may make the module bigger/smaller
or relocate variables whose address then changes. All locations that
these are referenced must be modified (either direct address or offset).
Sometimes other modules will get relocated too.

Now when you have relocatable object code distributed there is an alternative:
you recompile the module, and relink the entire kernel. The assumption is
that you have all the object modules...
-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: jesse@cats-chateau.net

Any opinions expressed are solely my own.
