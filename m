Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbWASGq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbWASGq0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 01:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbWASGq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 01:46:26 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:10932 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S964956AbWASGq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 01:46:26 -0500
Message-ID: <43CF1CCF.20007@wolfmountaingroup.com>
Date: Wed, 18 Jan 2006 21:59:59 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Inserting Commas into Those Big Numbers 
Content-Type: multipart/mixed;
 boundary="------------030601020003040109020005"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030601020003040109020005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


If anyone cares to make the kernel output more readable, heres a code 
snippet that formats any text string with numbers (decimal) to
insert commas.  I am too old and going blind looking at computer screen 
with these long numbers.  If useful to anyone, enjoy.

Jeff



--------------030601020003040109020005
Content-Type: text/x-csrc;
 name="sprintf_comma.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sprintf_comma.c"


void sprintf_comma(char *buf, char *fmt, ...)
{

     register long i, r, flag, len;
     va_list args;

     va_start(args, fmt);
     vsprintf(buf, fmt, args);
     va_end(args);

     for (len = i = strlen(buf), flag = 0; i >= 0; i--)
     {
	if (buf[i] >= '0' && buf[i] <= '9')
	{
	   if (++flag > 3)
	   {
	      flag = 1;
	      for (r = ++len; r > i; r--)
		 buf[r] = buf[r - 1];
	      buf[i + 1] = ',';
	   }
	}
     }
}


--------------030601020003040109020005--
