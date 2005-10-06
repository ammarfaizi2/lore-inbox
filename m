Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbVJFAvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbVJFAvt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 20:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbVJFAvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 20:51:48 -0400
Received: from highlandsun.propagation.net ([66.221.212.168]:42506 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S1751087AbVJFAvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 20:51:48 -0400
Message-ID: <43447516.30402@symas.com>
Date: Wed, 05 Oct 2005 17:51:34 -0700
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9a1) Gecko/20050925 SeaMonkey/1.1a
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
References: <DE88BDF02F4319469812588C7950A97E9312A6@ussunex1.palmsource.com> <20051006000340.GC10538@lkcl.net>
In-Reply-To: <20051006000340.GC10538@lkcl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy Luke...

Luke Kenneth Casson Leighton wrote:
> > If you can't do it with unix permissions or unix permissions + ACL,
> > you don't need to do it at all most likely, and even more likely
> > you

>  the bastion sftp example i gave which required selinux on top of a
>  much broader set of POSIX file permissions demonstrates the fallacy
>  of your statement.

>  try to achieve the same effect with POSIX - even POSIX ACLs (uploader
>  only has create and write, not read, not delete; downloader has read
>  and delete, not write, not create)

>  and you will fail, miserably, because under POSIX, write implies
>  create.

You're really muddying up the waters here. sftp is not POSIX. Like ftp, 
it presents an abstraction of a generic filesystem, and that abstraction 
lives at the application layer. As such, it is the application layer's 
responsibility to define what features may or may not be implemented. 
There are plenty of smart ftp servers that let you define precisely this 
type of ACLs for the ftp users. The fact that it is both possible and 
trivially easy to implement such an application on top of a POSIX 
runtime environment tells me that there's nothing broken here.

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

