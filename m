Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWEXOtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWEXOtE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 10:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWEXOtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 10:49:04 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:6196 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932310AbWEXOtC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 10:49:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UgFNAS/RIL/AxRpFINRtLBSylP7kgXuWJwCJeWITWULFsxf8UybytvnHmOddvQ62STpgur1nFsFUgLF18NfvVTr0e+gjNB3O8ZoXlzNK6x9VNHFrS886q/0FQ+P+IyA8LJObaowpKy0Zz9nThJixgJ9Db47ookg+4wT963noyCY=
Message-ID: <9e4733910605240749r1ce9e9fehcfffb2f2e3aeab60@mail.gmail.com>
Date: Wed, 24 May 2006 10:49:01 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Helge Hafting" <helge.hafting@aitel.hist.no>,
       "D. Hazelton" <dhazelton@enter.net>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <447465C6.3090501@ums.usu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <44700ACC.8070207@gmail.com>
	 <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com>
	 <200605230048.14708.dhazelton@enter.net>
	 <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com>
	 <6896241F-3389-4B20-9E42-3CCDDBFDD312@mac.com>
	 <44740533.7040702@aitel.hist.no> <447465C6.3090501@ums.usu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/06, Alexander E. Patrakov <patrakov@ums.usu.ru> wrote:
>   * Have a method in the framebuffer driver for clearing the screen and setting
> a known good mode, for the Linux equivalent of a "blue screen of death"

You can't change the mode, instead you have to track it and use the
one that is already set. Changing the mode on a lot of cards that we
don't have docs for requires making BIOS calls using VM86. VM86 only
runs from user space and user space may be dead when you want to
print. WIndows can take a different approach since they have access to
the video hardware docs.

-- 
Jon Smirl
jonsmirl@gmail.com
