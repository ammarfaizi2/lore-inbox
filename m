Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265544AbUFCRsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265544AbUFCRsc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 13:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264236AbUFCR2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 13:28:25 -0400
Received: from outmx005.isp.belgacom.be ([195.238.2.102]:54972 "EHLO
	outmx005.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S264337AbUFCRKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 13:10:35 -0400
Subject: mconf : find_menu
From: FabF <fabian.frederick@skynet.be>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1086282722.2295.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 03 Jun 2004 19:12:02 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I'd like to have some function able to find a menu struct with filename
& prompt in mconf.This one doesn't seem to give the best results.Someone
could help ? (Roman ?).

	I'm scanning internal list of menus, then next menu's list then parent
list ....

Regards,
FabF


struct menu* find_menu (const char *szfile, const char *szprompt, struct
menu* currentmenu)
{
if (!strcmp(menu_get_prompt(currentmenu), szprompt)){
                return currentmenu;
        }else
        if(currentmenu->list){
                find_menu(szfile, szprompt, currentmenu->list);
          }else
                if(currentmenu->next){
                          find_menu(szfile, szprompt,currentmenu->next);
                }
                     else if
((currentmenu->parent)&&(currentmenu->parent->next)){
                                find_menu(szfile, szprompt,
currentmenu->parent->next);


